json.extract! company, :id, :name, :email, :category, :description, :address, :phone, :registration_no, :created_at, :updated_at
json.url company_url(company, format: :json)
