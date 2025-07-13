json.extract! assessment, :id, :title, :starting_time, :ending_time, :candidate_selection, :job_id, :created_at, :updated_at
json.url assessment_url(assessment, format: :json)
