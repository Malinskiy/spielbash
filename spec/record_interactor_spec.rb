require 'spec_helper'

RSpec.describe 'RecordInteractor' do

  before do
    File.delete('/tmp/output.json') if File.exists?('/tmp/output.json')
  end

  it 'should record movie' do
    interactor = Spielbash::RecordInteractor.new
    interactor.execute(file_fixture('scenario_1.yaml'), '/tmp/output.json')
  end
end