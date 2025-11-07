import 'package:assignment1/assignment1.dart';

void main() {
  var bank = Bank();

  var savings = SavingsAccount(actNumber: "S123", actName: "Arun Budathoki", balance: 2000);
  var checking = CheckingAccount(actNumber: "C234", actName: "Krishna Sunuwar", balance: 1000);
  var premium = PremiumAccount(actNumber: "P456", actName: "Parbata Nepali", balance: 15000);
  var student = StudentAccount(actNumber: "ST789", actName: "Gambir Katuwal", balance: 1000);

  bank.createBankAccount(savings);
  bank.createBankAccount(checking);
  bank.createBankAccount(premium);
  bank.createBankAccount(student);

  // Transactions
  savings.deposit(200);
  savings.withdraw(100);
  checking.withdraw(1200);
  premium.calculateInterest();
  student.deposit(4200);
  student.withdraw(100);

  

  // Apply monthly interest to all interest-bearing accounts
  bank.applyMonthlyInterest();

  // Transfer money
  bank.transfer("P456", "S123", 500);

  // Reports
  bank.generateReport();

  // View transaction history
  savings.showTransactions();
  premium.showTransactions();
  student.showTransactions();
}
