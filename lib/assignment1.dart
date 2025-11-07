
// Abstract Base Class

abstract class BankAccount {
  String _actNumber;
  String _actName;
  double _balance;
  List<String> _transactions = []; 

  BankAccount({
    required String actNumber,
    required String actName,
    required double balance,
  })  : _actNumber = actNumber,
        _actName = actName,
        _balance = balance { 
    _transactions.add("Account created with initial balance \$$_balance");
  }

  // Getters and Setters
  String get accountNumber => _actNumber;
  String get holderName => _actName;
  double get balance => _balance;

  void updateBalance(double newAmount) {
    _balance = newAmount;
  }

  // Abstract methods
  void withdraw(double amount);
  void deposit(double amount);

  // Transaction tracking
  void recordTransaction(String description) {
    _transactions.add(description);
  }

  void showTransactions() {
    print("\nTransaction history for $_actName ($_actNumber):");
    for (var t in _transactions) {
      print(" - $t");
    }
  }

  // Display info
  void displayInfo() {
    print("--------------------------");
    print("Account Number: $_actNumber");
    print("Account Holder: $_actName");
    print("Balance: \$$_balance");
  }
}


// Interest Interface

abstract class InterestBearing {
  void calculateInterest();
}

// Savings Account

class SavingsAccount extends BankAccount implements InterestBearing {
  static const double _minBalance = 500;
  static const double _interestRate = 0.02;
  int _withdrawalCount = 0;
  static const int _withdrawalLimit = 3;

  SavingsAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      recordTransaction("Deposited \$$amount");
      print("\$$amount deposited into Savings Account");
    } else {
      print("Deposit amount must be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (_withdrawalCount >= _withdrawalLimit) {
      print("Withdrawal limit reached for this month.");
      return;
    }
    if (balance - amount < _minBalance) {
      print("Cannot withdraw: Must maintain at least \$$_minBalance.");
      return;
    }

    updateBalance(balance - amount);
    _withdrawalCount++;
    recordTransaction("Withdrew \$$amount");
    print("\$$amount withdrawn from Savings Account.");
  }

  @override
  void calculateInterest() {
    double interestAmt = balance * _interestRate;
    updateBalance(balance + interestAmt);
    recordTransaction("Interest of \$${interestAmt.toStringAsFixed(2)} added");
    print("Interest of \$$interestAmt applied.");
  }
}


// Checking Account

class CheckingAccount extends BankAccount {
  static const double _overdraftFee = 35;

  CheckingAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      recordTransaction("Deposited \$$amount");
      print("\$$amount deposited into Checking Account");
    } else {
      print("Deposit amount must be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
      return;
    }

    updateBalance(balance - amount);
    if (balance < 0) {
      updateBalance(balance - _overdraftFee);
      recordTransaction("Overdraft fee of \$$_overdraftFee charged");
      print("\$$_overdraftFee overdraft fee applied.");
    }

    recordTransaction("Withdrew \$$amount");
    print("\$$amount withdrawn from Checking Account.");
  }
}

// Premium Account

class PremiumAccount extends BankAccount implements InterestBearing {
  static const double _minBalance = 10000;
  static const double _interestRate = 0.05;

  PremiumAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      recordTransaction("Deposited \$$amount");
      print("\$$amount deposited into Premium Account");
    } else {
      print("Deposit amount must be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < _minBalance) {
      print("Minimum balance of \$$_minBalance required.");
      return;
    }

    updateBalance(balance - amount);
    recordTransaction("Withdrew \$$amount");
    print("\$$amount withdrawn from Premium Account.");
  }

  @override
  void calculateInterest() {
    double interestAmt = balance * _interestRate;
    updateBalance(balance + interestAmt);
    recordTransaction("Interest of \$$interestAmt added");
    print("Interest of \$$interestAmt applied.");
  }
}


// Student Account

class StudentAccount extends BankAccount {
  static const double _maxBalance = 5000;

  StudentAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (balance + amount > _maxBalance) {
      print("Cannot deposit: Maximum balance of \$$_maxBalance reached.");
      return;
    }

    updateBalance(balance + amount);
    recordTransaction("Deposited \$$amount");
    print("\$$amount deposited into Student Account.");
  }

  @override
  void withdraw(double amount) {
    if (amount > balance) {
      print("Insufficient balance.");
      return;
    }

    updateBalance(balance - amount);
    recordTransaction("Withdrew \$${amount.toStringAsFixed(2)}");
    print("\$$amount withdrawn from Student Account.");
  }
}


// Bank Class

class Bank {
  final List<BankAccount> _accounts = [];

  void createBankAccount(BankAccount account) {
    _accounts.add(account);
    print("Bank account ${account.accountNumber} created successfully.");
  }

  BankAccount? findAccount(String accountNumber) {
    for (var account in _accounts) {
      if (account.accountNumber == accountNumber) {
        return account;
      }
    }
    return null;
  }

  void transfer(String fromAcc, String toAcc, double amount) {
    var from = findAccount(fromAcc);
    var to = findAccount(toAcc);

    if (from == null || to == null) {
      print("One or both accounts not found.");
      return;
    }
    if (from.balance < amount) {
      print("Insufficient funds for transfer.");
      return;
    }

    from.withdraw(amount);
    to.deposit(amount);

    from.recordTransaction("Transferred \$${amount.toStringAsFixed(2)} to ${to.accountNumber}");
    to.recordTransaction("Received \$${amount.toStringAsFixed(2)} from ${from.accountNumber}");

    print("Transfer of \$$amount from ${from.accountNumber} to ${to.accountNumber} completed.");
  }

  
  void applyMonthlyInterest() {
    for (var acc in _accounts) {
      if (acc is InterestBearing) {
        (acc as InterestBearing).calculateInterest();
      }
    }
    print("Monthly interest applied to all eligible accounts.");
  }

  void generateReport() {
    print("\n======= BANK REPORT =======");
    for (var acc in _accounts) {
      acc.displayInfo();
    }
  }
}

