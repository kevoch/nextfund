json.array!(@projects) do |project|
  json.extract! project, :id, :user_id, :campaign_title, :images, :category, :address, :deadline, :video_upload, :summary, :amount_needed, :amount_achieved
  json.url project_url(project, format: :json)
end
