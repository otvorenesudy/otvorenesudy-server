source /home/deploy/.profile

cd /home/deploy/projects/opencourts_production/current
/usr/bin/env kill -0 $(cat /home/deploy/projects/opencourts_production/shared/tmp/pids/sidekiq.pid)
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/opencourts_production/shared/tmp/pids/sidekiq.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /home/deploy/projects/opencourts_production/shared/tmp/pids/sidekiq.pid --environment production --logfile /home/deploy/projects/opencourts_production/shared/log/sidekiq.log --daemon

cd /home/deploy/projects/opencourts-api-production/current
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/opencourts-api-production/shared/tmp/pids/sidekiq-0.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /home/deploy/projects/opencourts-api-production/shared/tmp/pids/sidekiq-0.pid --environment production --logfile /home/deploy/projects/opencourts-api-production/shared/log/sidekiq.log --daemon

cd /home/deploy/projects/opencourts-prokuratura-production/current
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/opencourts-prokuratura-production/shared/tmp/pids/sidekiq-0.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /home/deploy/projects/opencourts-prokuratura-production/shared/tmp/pids/sidekiq-0.pid --environment production --logfile /home/deploy/projects/opencourts-prokuratura-production/shared/log/sidekiq.log --daemon
