json.extract! job, :id, :title, :overview, :responsibilities, :requirements, :benifits, :location, :deadline, :salary_range, :created_at, :updated_at
json.url job_url(job, format: :json)
