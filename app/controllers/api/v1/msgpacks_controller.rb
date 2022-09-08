require 'msgpack'

module Api
  module V1
    class MsgpacksController < ApplicationController

        def index
            msgpack = {
                "guid" => "707c08f4874a7006b5d502f30fac1a53a434b531d66cb5eaabb3dc605fbbf875",
                "ymd" => Time.now.to_i,
                "content_code" => "test20201209gendai_20201121",
                "page_no" => 1,
                "views" => 1,
                "times" => 1,
                "x" => 111,
                "y" => 222,
                "zoom" => 250,
                "resolution" => 100,
                "search_words" => "TEST",
                "favorite" => 1,
                "bookmark" => 1
            }
            page_msgpack = msgpack.to_msgpack
            File.binwrite('page.msgpack',page_msgpack)
            Rails.logger.info("unpack #{MessagePack.unpack(page_msgpack)}")

            #render :text => page_msgpack, :type => 'application/x-msgpack'
            render json: page_msgpack gzcontent_type: "application/x-msgpack"
        end

        def show
        end
    
        # POST /msgpacks
        def create
            msgpack = {
                "guid" => "707c08f4874a7006b5d502f30fac1a53a434b531d66cb5eaabb3dc605fbbf875",
                "ymd" => Time.now.to_i,
                "content_code" => "test20201209gendai_20201121",
                "page_no" => 1,
                "views" => 1,
                "times" => 1,
                "x" => 111,
                "y" => 222,
                "zoom" => 250,
                "resolution" => 100,
                "search_words" => "TEST",
                "favorite" => 1,
                "bookmark" => 1
            }
            page_msgpack = msgpack.to_msgpack
            File.binwrite('page.msgpack',page_msgpack)
            Rails.logger.info("unpack #{MessagePack.unpack(page_msgpack)}")

            render json: page_msgpack gzcontent_type: "application/x-msgpack"

        end

        def destroy
        end

        def update
        end
        
    end
  end
end