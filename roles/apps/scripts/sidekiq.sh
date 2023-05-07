source /home/deploy/.profile

cd /home/deploy/projects/otvorenesudy-production/current
/usr/bin/env kill -0 $(cat /home/deploy/projects/otvorenesudy-production/shared/tmp/pids/sidekiq.pid)
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/otvorenesudy-production/shared/tmp/pids/sidekiq.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /home/deploy/projects/otvorenesudy-production/shared/tmp/pids/# sidekiq.pid --environment production --logfile /home/deploy/projects/otvorenesudy-production/shared/log/sidekiq.log --daemon

cd /home/deploy/projects/otvorenesudy-api-production/current
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/otvorenesudy-api-production/shared/tmp/pids/sidekiq-0.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /home/deploy/projects/otvorenesudy-api-production/shared/tmp/pids/sidekiq-0.pid --environment production --logfile /home/deploy/projects/otvorenesudy-api-production/shared/log/sidekiq.log --daemon

cd /home/deploy/projects/otvorenesudy-prokuratura-production/current
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/otvorenesudy-prokuratura-production/shared/tmp/pids/sidekiq-0.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiqctl stop /home/deploy/projects/otvorenesudy-prokuratura-production/shared/tmp/pids/sidekiq-1.pid 10
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 0 --pidfile /home/deploy/projects/otvorenesudy-prokuratura-production/shared/tmp/pids/sidekiq-0.pid --environment production --logfile /home/deploy/projects/otvorenesudy-prokuratura-production/shared/log/sidekiq-0.log -C /home/deploy/projects/otvorenesudy-prokuratura-production/current/config/sidekiq-1.yml --daemon
$HOME/.rbenv/bin/rbenv exec bundle exec sidekiq --index 1 --pidfile /home/deploy/projects/otvorenesudy-prokuratura-production/shared/tmp/pids/sidekiq-1.pid --environment production --logfile /home/deploy/projects/otvorenesudy-prokuratura-production/shared/log/sidekiq-1.log -C /home/deploy/projects/otvorenesudy-prokuratura-production/current/config/sidekiq-2.yml --daemon
