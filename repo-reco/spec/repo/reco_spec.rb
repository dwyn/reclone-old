require "spec_helper"

RSpec.describe Repo::Reco do
  it "has a version number" do
    expect(Repo::Reco::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
