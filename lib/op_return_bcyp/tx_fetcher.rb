module OpReturnBcyp
  class TXFetcher

    include Utils
    
    def initialize(address:, api:)
      @address = address
      @api     = api     # BlockCypher::Api
    end

    def all
      transactions = address_txs_get


      # ---
      # TODO: refactor

      transactions = transactions.map!{ |tx| sym_keys tx }
      transactions_ids = transactions.map{ |tx| tx.f :tx_hash }
      transactions_ids.uniq!

      transactions = transactions_ids.map do |tx_id|
        transaction = @api.blockchain_transaction tx_id
        transaction = sym_keys transaction
        outputs     = transaction.f :outputs
        outputs     = outputs.map{ |out| sym_keys out }
        outputs.select! do |out|
          out.f(:script_type) == "null-data"
        end
        outputs.map do |out|
          op_return = out.f :data_string
          op_return = HE.decode op_return # decode html-entities
          {
            tx:         tx_id,
            op_return:  op_return,
          }
        end
      end.compact.flatten

      transactions

    end

    private

    def address_txs_get
      details = address_details_get

      raise "NoTXAddress - This address has no tx yet, OpReturn data will be empty" unless details[:txrefs]

      transactions = details.f :txrefs

      transactions
    end

    def address_details_get
      address = @address
      details = address_details_api_get address: address
      details = sym_keys details
      details
    end

    protected

    def address_details_api_get(address:)
      @api.address_details address
    rescue BlockCypher::Api::Error => e
      # raise TXFetcherBcypError # blockcypher error while trying to fetch tx - more specifically while trying to fetch address details # TXFetcherBcypAddressDetailsError - BcypAddressDetailsFetchError
      # ...
      blockcypher_error_rescue_human err: e
    end

    def address_details_api_error!(err:)
      # FIXME: naive way
      err = err.message.split("Response:")[1]
      error_resp =  Oj.load err
      error_resp["error"]
    end

    # ---

    def blockcypher_error_rescue_human(err:)
      puts "Error: API Error from BlockCypher API"
      puts "response_message:"
      error = address_details_api_error! err: err
      puts error
      puts
      puts "exiting..."
      exit
    end

  end
end
