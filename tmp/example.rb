require_relative '../lib/op_return_bcyp'

TX = OpReturnBcyp::TX

transactions = TX.all "1Gj3S8GPgRQrP4gUCKVMFmMSdM6bMkB4wz"
p transactions
