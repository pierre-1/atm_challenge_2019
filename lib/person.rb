require 'pry'
require './lib/account'
require './lib/atm'

class Person
    attr_accessor :name, :cash, :account

    def initialize(attrs = {})
        @name = set_name(attrs[:name])
        @cash = 0
        @account = nil
    end

    def create_account
        self.account = Account.new(owner: self)
    end

    def set_owner_of_account(name)
        name
    end

    def deposit(amount)
        if self.account != nil 
        account.balance += amount
        @cash -= amount
        else raise "No account present"
        end
    end  
    
    def withdraw(args = {})
        @account == nil ? missing_account : withdraw_funds(args)
    end

    private 
    
    def withdraw_funds(args)
        args[:atm] == nil ? missing_atm : atm = args[:atm]
        account = @account
        amount = args[:amount]
        pin = args[:pin]
        response = atm.withdraw(amount, pin, account)
        response[:status] == true ? increase_cash(response) : response
    end

    def set_name(name)
        name == nil ? missing_name : name
    end

    def increase_cash(response)
        @cash += response[:amount]
    end

    def missing_name
        raise ArgumentError, 'A name is required'
    end

    def missing_account
        raise RuntimeError, 'No account present'
    end

    def missing_atm
        raise RuntimeError, 'An ATM is required'
    end

end
