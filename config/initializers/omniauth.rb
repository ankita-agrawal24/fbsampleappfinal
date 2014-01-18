OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook,'471927032913567','f214415415de166f66e23f04bb1f5b75'
end