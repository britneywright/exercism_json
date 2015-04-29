require 'github'

RSpec.describe Github::Repo do
  let :contributor_hash do
    { :login=>"kytrinyx",
      :id=>276834,
      :avatar_url=>"https://avatars.githubusercontent.com/u/276834?v=3",
      :gravatar_id=>"",
      :url=>"https://api.github.com/users/kytrinyx",
      :html_url=>"https://github.com/kytrinyx",
      :followers_url=>"https://api.github.com/users/kytrinyx/followers",
      :following_url=>"https://api.github.com/users/kytrinyx/following{/other_user}", :gists_url=>"https://api.github.com/users/kytrinyx/gists{/gist_id}",
      :starred_url=>"https://api.github.com/users/kytrinyx/starred{/owner}{/repo}",
      :subscriptions_url=>"https://api.github.com/users/kytrinyx/subscriptions",
      :organizations_url=>"https://api.github.com/users/kytrinyx/orgs",
      :repos_url=>"https://api.github.com/users/kytrinyx/repos",
      :events_url=>"https://api.github.com/users/kytrinyx/events{/privacy}",
      :received_events_url=>"https://api.github.com/users/kytrinyx/received_events",
      :type=>"User",
      :site_admin=>false,
      :contributions=>2713,
      :repo=>"exercism.io"}
  end
  let(:contributor) { Github::Contributor.new contributor_hash }

  it "creates a contributor with readable attributes" do
    expect(contributor.login).to eq "kytrinyx"
    expect(contributor.id).to eq 276834
    expect(contributor.avatar_url).to eq "https://avatars.githubusercontent.com/u/276834?v=3"
    expect(contributor.contributions).to eq 2713
    expect(contributor.repo).to eq "exercism.io"
  end
end
