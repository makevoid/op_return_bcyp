module OpReturnBcyp

  class TXFetcher
    def initialize(address)
      @address = address
    end

    def all(address)
      address = @address
      # tx
      details = BC.address_details address
      # p BC.address_full_txs ADDRESS

      details = sym_keys details

      raise "NoTXAddress - This address has no tx yet, OpReturn data will be empty" unless details[:txrefs]

      transactions = details.f :txrefs

      transactions = transactions.map!{ |tx| sym_keys tx }
      transactions_ids = transactions.map{ |tx| tx.f :tx_hash }
      transactions_ids.uniq!

      transactions = transactions_ids.map do |tx_id|
        transaction = BC.blockchain_transaction tx_id
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
  end
  
end
