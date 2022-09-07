require 'msgpack'
require 'zlib'

class TestsController < ApplicationController
  before_action :set_test, only: [:show, :update, :destroy]

  # GET /tests
  def index
    @tests = Test.all
    msgpac_create
    render json: @tests
  end

  # GET /tests/1
  def show
    render json: @test
  end

  # POST /tests
  def create
    @test = Test.new(test_params)

    if @test.save
      render json: @test, status: :created, location: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @test.update(test_params)
      render json: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tests/1
  def destroy
    @test.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def test_params
      params.require(:test).permit(:header, :body)
    end

    def msgpac_create
      msg = [1,2,3].to_msgpack
      Rails.logger.info("msgpack #{msg}")
      Rails.logger.info("msgpack #{MessagePack.unpack(msg)}")
      File.binwrite('mydata.msgpack',msg)

      #NG
      msgpack = {
        "guid" => "707c08f4874a7006b5d502f30fac1a53a434b531d66cb5eaabb3dc605fbbf875",
        "ymd" => Time.now.to_s,
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
      tmp = File.binread('page.msgpack')
      Rails.logger.info("unpack #{MessagePack.unpack(tmp)}")
      
      Zlib::GzipWriter.open("page.msgpack.gz"){|gz|
        data = File.open('page.msgpack','rb') {|f| f.read}
        gz.write(data)
        gz.close()
      }

      #From Android Client
      Zlib::GzipReader.open("android_page.msgpack.gz"){|gz|
        gz_msg = gz.read()
        Rails.logger.info("*** android_page.msgpack.gz pack #{gz_msg} ***")
        begin
          Rails.logger.info("*** android_page.msgpack.gz unpack #{MessagePack.unpack(gz_msg)} ***")
        rescue => e
          Rails.logger.error("*** #{e.backtrace.join("\n")} ***") 
        end
        gz.close()
      }

      # From Android Client ungzip
      page_msg = File.binread('android_page.msgpack')
      Rails.logger.info("*** android_page.msgpack pack #{page_msg} ***")
      Rails.logger.info("*** android_page.msgpack unpack #{MessagePack.unpack(page_msg)} ***")

    end
  
end
