require_relative 'op_return_bcyp/version'
require_relative 'op_return_bcyp/env'

module OpReturnBcyp

  class TX
    BC = BlockCypher::Api.new

    extend Caching

    def self.all(address)
      cache "opr_txs:#{address}" do
        tx_fetcher_all
      end
    end

    private
  
    def self.tx_fetcher_all
      tx_f = TXFetcher.new address: address
      tx_f.all
    end
  end


end


if $0 == __FILE__
  require 'pp'

  transactions = op_return_transactions ADDRESS

  puts "Transactions data:"
  pp transactions
end
