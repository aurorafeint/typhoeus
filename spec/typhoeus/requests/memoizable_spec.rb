require 'spec_helper'

describe Typhoeus::Requests::Memoizable do
  let(:options) { {} }
  let(:request) { Typhoeus::Request.new("fu", options) }
  let(:response) { Typhoeus::Response.new }
  let(:hydra) { Typhoeus::Hydra.new }

  describe "#set_response" do
    context "when memoization activated" do
      before { Typhoeus::Config.memoize = true }
      after { Typhoeus::Config.memoize = false }

      context "when GET request" do
        let(:options) { {:method => :get} }
        before { request.hydra = hydra }

        it "stores response in memory" do
          request.response = response
          hydra.memory[request].should be
        end
      end

      context "when no GET request" do
        let(:options) { {:method => :post} }

        it "doesn't store response in memory" do
          request.response = response
          hydra.memory[request].should be_nil
        end
      end
    end
  end
end
