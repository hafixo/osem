require 'spec_helper'

describe ConferenceController do
  let(:conference) { create(:conference,  splashpage: create(:splashpage, public: true), venue: create(:venue)) }
  let!(:cfp) { create(:cfp, program: conference.program) }
  let(:room) { create(:room, venue: conference.venue) }

  describe 'GET #index' do
    it 'Response code is 200' do
      get :index
      expect(response.response_code).to eq(200)
    end

    it 'should redirect to default conference' do
      default_conference = create(:conference,  splashpage: create(:splashpage, public: true, show_by_default: true))

      get :index
      expect(response).to redirect_to(conference_path(default_conference.short_title))
    end
  end

  describe 'GET #show' do
    context 'conference made public' do
      it 'assigns the requested conference to conference' do
        get :show, id: conference.short_title
        expect(assigns(:conference)).to eq conference
      end

      it 'renders the show template' do
        get :show, id: conference.short_title
        expect(response).to render_template :show
      end
    end
  end

  describe 'OPTIONS #index' do
    it 'Response code is 200' do
      process :index, 'OPTIONS'
      expect(response.response_code).to eq(200)
    end
  end

end
