require 'spec_helper'

describe 'POST to /score' do
  context 'with valid lastname and dob' do
    it 'returns json with voter info and scores' do
      get '/score', {dob:'19901018', lastname: 'CHESTNUT'}

      expect(last_response.body).to include('CHESTNUT')
      expect(last_response.body).to include('KEVIN')
      expect(last_response.body).to include('1990-10-18')
    end
  end
end
