
DockerRepo = ENV['DOCKER_REPO'] or abort "DOCKER_REPO not set, "
DockerTag  = ENV['DOCKER_TAG'] or abort "DOCKER_TAG not set"

TaggedName = "%s:%s"  % [ ENV['DOCKER_REPO'], ENV['DOCKER_TAG'] ]


task :default => "docker:build"

task :all => ["docker:build", "docker:push", "ci:build", "ci:push"]

namespace :docker do

  task :build do
    sh "docker build --tag %s --tag latest ." % TaggedName
  end

  task :push do
    sh "docker push %s" % TaggedName
  end

end

namespace :ci do

  CITaggedName = "%s-ci" % TaggedName

  task :build do
    chdir 'ci' do
      sh "docker build --tag %s --tag latest-ci ." % CITaggedName
    end
  end

  task :push do
    sh "docker push %s" % CITaggedName
  end
end
