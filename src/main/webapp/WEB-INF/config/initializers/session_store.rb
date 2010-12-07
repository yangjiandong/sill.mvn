# Be sure to restart your server when you modify this file.

# Sill::Application.config.session_store :cookie_store, :key => '_sill_session'

# 采用数据库保存
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
Sill::Application.config.session_store :active_record_store
