require 'github'

RSpec.describe Github::Repo do
  let :repo_hash do
    {:id=>22583170,
      :name=>"analysseur",
      :full_name=>"exercism/analysseur",
      :owner=>
        {:login=>"exercism", 
          :id=>5624255, 
          :avatar_url=>"https://avatars.githubusercontent.com/u/5624255?v=3", 
          :gravatar_id=>"", 
          :url=>"https://api.github.com/users/exercism", 
          :html_url=>"https://github.com/exercism", 
          :followers_url=>"https://api.github.com/users/exercism/followers", 
          :following_url=>"https://api.github.com/users/exercism/following{/other_user}",
          :gists_url=>"https://api.github.com/users/exercism/gists{/gist_id}",
          :starred_url=>"https://api.github.com/users/exercism/starred{/owner}{/repo}",
          :subscriptions_url=>"https://api.github.com/users/exercism/subscriptions",
          :organizations_url=>"https://api.github.com/users/exercism/orgs",
          :repos_url=>"https://api.github.com/users/exercism/repos",
          :events_url=>"https://api.github.com/users/exercism/events{/privacy}",
          :received_events_url=>"https://api.github.com/users/exercism/received_events",
          :type=>"Organization",
          :site_admin=>false},
      :private=>false,
      :html_url=>"https://github.com/exercism/analysseur",
      :description=>"Light wrapper around JacobNinja's codeminer for exercism project",
      :fork=>false,
      :url=>"https://api.github.com/repos/exercism/analysseur",
      :forks_url=>"https://api.github.com/repos/exercism/analysseur/forks",
      :keys_url=>"https://api.github.com/repos/exercism/analysseur/keys{/key_id}",
      :collaborators_url=>"https://api.github.com/repos/exercism/analysseur/collaborators{/collaborator}",
      :teams_url=>"https://api.github.com/repos/exercism/analysseur/teams",
      :hooks_url=>"https://api.github.com/repos/exercism/analysseur/hooks",
      :issue_events_url=>"https://api.github.com/repos/exercism/analysseur/issues/events{/number}",
      :events_url=>"https://api.github.com/repos/exercism/analysseur/events",
      :assignees_url=>"https://api.github.com/repos/exercism/analysseur/assignees{/user}",
      :branches_url=>"https://api.github.com/repos/exercism/analysseur/branches{/branch}",
      :tags_url=>"https://api.github.com/repos/exercism/analysseur/tags",
      :blobs_url=>"https://api.github.com/repos/exercism/analysseur/git/blobs{/sha}",
      :git_tags_url=>"https://api.github.com/repos/exercism/analysseur/git/tags{/sha}",
      :git_refs_url=>"https://api.github.com/repos/exercism/analysseur/git/refs{/sha}",
      :trees_url=>"https://api.github.com/repos/exercism/analysseur/git/trees{/sha}",
      :statuses_url=>"https://api.github.com/repos/exercism/analysseur/statuses/{sha}",
      :languages_url=>"https://api.github.com/repos/exercism/analysseur/languages",
      :stargazers_url=>"https://api.github.com/repos/exercism/analysseur/stargazers",
      :contributors_url=>"https://api.github.com/repos/exercism/analysseur/contributors",
      :subscribers_url=>"https://api.github.com/repos/exercism/analysseur/subscribers",
      :subscription_url=>"https://api.github.com/repos/exercism/analysseur/subscription",
      :commits_url=>"https://api.github.com/repos/exercism/analysseur/commits{/sha}",
      :git_commits_url=>"https://api.github.com/repos/exercism/analysseur/git/commits{/sha}",
      :comments_url=>"https://api.github.com/repos/exercism/analysseur/comments{/number}",
      :issue_comment_url=>"https://api.github.com/repos/exercism/analysseur/issues/comments{/number}",
      :contents_url=>"https://api.github.com/repos/exercism/analysseur/contents/{+path}",
      :compare_url=>"https://api.github.com/repos/exercism/analysseur/compare/{base}...{head}",
      :merges_url=>"https://api.github.com/repos/exercism/analysseur/merges",
      :archive_url=>"https://api.github.com/repos/exercism/analysseur/{archive_format}{/ref}",
      :downloads_url=>"https://api.github.com/repos/exercism/analysseur/downloads",
      :issues_url=>"https://api.github.com/repos/exercism/analysseur/issues{/number}",
      :pulls_url=>"https://api.github.com/repos/exercism/analysseur/pulls{/number}",
      :milestones_url=>"https://api.github.com/repos/exercism/analysseur/milestones{/number}",
      :notifications_url=>"https://api.github.com/repos/exercism/analysseur/notifications{?since,all,participating}",
      :labels_url=>"https://api.github.com/repos/exercism/analysseur/labels{/name}",
      :releases_url=>"https://api.github.com/repos/exercism/analysseur/releases{/id}",
      :created_at=>"2014-08-03T20:40:40Z",
      :updated_at=>"2015-04-25T13:00:00Z",
      :pushed_at=>"2015-04-25T12:59:58Z",
      :git_url=>"git://github.com/exercism/analysseur.git",
      :ssh_url=>"git@github.com:exercism/analysseur.git",
      :clone_url=>"https://github.com/exercism/analysseur.git",
      :svn_url=>"https://github.com/exercism/analysseur",
      :homepage=>nil,
      :size=>192,
      :stargazers_count=>0,
      :watchers_count=>0,
      :language=>"Ruby",
      :has_issues=>true,
      :has_downloads=>true,
      :has_wiki=>true,
      :has_pages=>false,
      :forks_count=>0,
      :mirror_url=>nil,
      :open_issues_count=>0,
      :forks=>0,
      :open_issues=>0,
      :watchers=>0,
      :default_branch=>"master"
    }
  end
  let(:repo) { Github::Repo.new repo_hash }

  it "creates a repo object with readable attributes" do
    expect(repo.id).to eq 22583170
    expect(repo.name).to eq "analysseur"
    expect(repo.full_name).to eq "exercism/analysseur"
    expect(repo.html_url).to eq "https://github.com/exercism/analysseur"
    expect(repo.description).to eq "Light wrapper around JacobNinja's codeminer for exercism project"
    expect(repo.url).to eq "https://api.github.com/repos/exercism/analysseur"
    expect(repo.contributors_url).to eq "https://api.github.com/repos/exercism/analysseur/contributors"
    expect(repo.created_at).to eq "2014-08-03T20:40:40Z"
    expect(repo.updated_at).to eq "2015-04-25T13:00:00Z"
    expect(repo.size).to eq 192
  end
end

