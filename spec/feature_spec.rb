# require 'oystercard'
#
# describe Oystercard do
# # In order to use public transport
# # As a customer
# # I want money on my card
# it 'so I can use public transport, I want money on my card' do
#   oystercard = Oystercard.new
#   expect(oystercard.balance).to eq(0)
# end
#
#
# # In order to keep using public transport
# # As a customer
# # I want to add money to my card
# it 'so I can keep using public transport, I want to add money to my card' do
#   oystercard = Oystercard.new
#   oystercard.top_up(5)
#   expect(oystercard.balance).to eq(5)
# end
#
# # In order to protect my money
# # As a customer
# # I want a maxium limit (of £90) on my card
# it 'so I can protect my money, I want a maximum limit on card' do
#   oystercard = Oystercard.new
#   expect {oystercard.top_up(91)}.to raise_error 'Unable to top up: £90 limit reached'
# end
# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
#
# In order to get through the barriers
# As a customer
# I need to touch in and out
#
# In order to pay for my journey
# As a customer
# I need to have the minimum amount for a single journey
#
# In order to pay for my journey
# As a customer
# I need to pay for my journey when it's complete
#
# In order to pay for my journey
# As a customer
# I need to know where I've travelled from
#
# In order to know where I have been
# As a customer
# I want to see to all my previous trips
#
# In order to know how far I have travelled
# As a customer
# I want to know what zone a station is in
#
# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
#
# In order to be charged the correct amount
# As a customer
# I need to have the correct fare calculated
#end
