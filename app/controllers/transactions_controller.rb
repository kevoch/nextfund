class TransactionsController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate.to_s

    @project = Project.find_by(id: params[:id])
    @transaction = Transaction.new
  end

  def create

    nonce = params[:payment_method_nonce]
    render action: :new and return unless nonce
    result = Braintree::Transaction.sale(
      amount: params[:transaction][:amount], #to be changed to let user specify how much they want to pay
      payment_method_nonce: params[:payment_method_nonce]
    )
    @project = Project.find(params[:transaction][:project_id])

    if result.success?
      Transaction.create(amount: params[:transaction][:amount], user_id: current_user.id, project_id: params[:transaction][:project_id], braintree_transaction_id: result.transaction.id, status: result.transaction.status, last_4: result.transaction.credit_card_details.last_4)
      current_amount = @project.amount_achieved.to_i
      updated_amount  = current_amount + params[:transaction][:amount].to_i

      @project.update(amount_achieved: updated_amount)
      donation_percentage = @project.amount_achieved.to_f/@project.amount_needed.to_f
    
      if (donation_percentage < 1) && (0.95 < donation_percentage)       
            @project.create_activity :donation_milestone, owner: current_user, recipient: @project.user
      end

      url = 'http://localhost:3000/transactions/new?id=' + @project.id.to_s + '#step3'
      byebug

      # current_user.purchase_cart_movies!
      # redirect_to project_path(@project), notice: "Congratulations! Your transaction has been successfully processed!"
      redirect_to url
    else

      if result.errors.present?
        @messages = []
        result.errors.each {|x| @messages << x.message}
        @transaction = Transaction.new
        redirect_to project_path(@project), notice: @messages.join(" ")
      else
        Transaction.create(amount: params[:transaction][:amount], user_id: current_user.id, project_id: params[:transaction][:project_id], braintree_transaction_id: result.transaction.id, status: result.transaction.status, last_4: result.transaction.credit_card_details.last_4)

      @client_token = Braintree::ClientToken.generate.to_s
      @transaction = Transaction.new

      redirect_to project_path(@project), notice: "Something went wrong while processing your transaction. Please try again!"
      end
    end


    # reserve to save the transaction details into database

  end

end
