all:
	bundle install
	bundle exec fastlane test

bump:
	git reset --hard HEAD
	gem bump --version patch
	git push origin master

release:
	rm -rf Gemfile.lock
	bundle install
	bundle exec rake release
