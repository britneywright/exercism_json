require 'open3'
require 'json'

RSpec.describe 'github' do
  let(:path_to_executable) { File.expand_path '../bin/github', __dir__ }
  let(:user_name)          { 'exercism' }
  let(:repo_name)          { 'exercism.io' }
  let(:output_filename)    { 'test_contributors.json' }

  after { File.delete output_filename if File.exist? output_filename }
  
  it 'queries the data from github' do
    stdout, stderr, status = Open3.capture3 path_to_executable,
                                           user_name,
                                           output_filename,
                                           repo_name
                                           
    expect(stderr).to be_empty
    expect(status).to be_success
    expect(stdout).to include output_filename

    json = JSON.parse(File.read(output_filename))

    expect(json.keys.sort).to eq ["login","id","avatar_url","contributions"]
  end
end
