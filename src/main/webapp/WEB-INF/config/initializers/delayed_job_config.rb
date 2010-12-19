# The default Worker.max_attempts is 25. After this, the job either deleted (default), or left in the database with “failed_at” set.
# With the default of 25 attempts, the last retry will be 20 days later, with the last interval being almost 100 hours.

# The default Worker.max_run_time is 4.hours. If your job takes longer than that, another computer could pick it up. It’s up to you to
# make sure your job doesn’t exceed this time. You should set this to the longest time you think the job could take.

# By default, it will delete failed jobs (and it always deletes successful jobs). If you want to keep failed jobs, set
# Delayed::Worker.destroy_failed_jobs = false. The failed jobs will be marked with non-null failed_at.

# By default all jobs are scheduled with priority = 0, which is top priority. You can change this by setting Delayed::Worker.default_priority to something else. Lower numbers have higher priority.

# config/initializers/delayed_job_config.rb
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes

