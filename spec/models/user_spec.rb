require 'spec_helper'

describe User do
  subject { create(:user) }

  describe '.find_or_create_from_auth' do
    let(:auth_hash) do
      Fixture(:soundcloud_auth)
    end

    it 'creates a user' do
      expect do
        User.find_or_create_from_auth(auth_hash)
      end.to change(User, :count).by(1)
    end

    it 'sets the correct attributes' do
      user = User.find_or_create_from_auth(auth_hash)
      expect(user.username).to    eq(auth_hash['info']['nickname'])
      expect(user.provider_id).to eq(auth_hash['uid'].to_s)
    end

    it 'finds an existing user' do
      user = User.find_or_create_from_auth(auth_hash)

      expect(User.find_or_create_from_auth(auth_hash)).to eq(user)
    end
  end

  it 'has a username' do
    expect(subject.username).to be_present
  end

  it 'has a provider_id' do
    expect(subject.provider_id).to be_present
  end

  it 'has uploaded nodes' do
    node = create(:node, uploader: subject)
    expect(subject.uploaded_nodes).to include(node)
  end
end
