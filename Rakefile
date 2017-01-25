
DockerRepo = ENV['DOCKER_REPO'] or abort "DOCKER_REPO not set"
DockerTag  = ENV['DOCKER_TAG'] or abort "DOCKER_TAG not set"


TaggedName = "%s:%s"  % [ ENV['DOCKER_REPO'], ENV['DOCKER_TAG'] ]

namespace :docker do

  task :build do
    sh "docker build --tag %s ." % TaggedName
  end

  task :push do
    sh "docker push %s" % TaggedName
  end

end


namespace :wercker do

  task :dev do
    sh "wercker dev"
  end

  task :build do
    sh "wercker build"
  end

end
