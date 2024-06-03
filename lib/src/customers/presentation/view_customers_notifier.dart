import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/customers/models/customer.dart';

class ViewCustomersNotifier extends Notifier<List<Customer>> {
  @override
  List<Customer> build() {
    return const <Customer>[];
  }

  void add(Customer newCustomer) {
    state = [...state, newCustomer];
  }

  void edit(Customer editedCustomer) {
    List<Customer> customers = [...state];
    int index = customers
        .indexWhere((customer) => customer.guid == editedCustomer.guid);
    Customer existing = customers
        .firstWhere((customer) => customer.guid == editedCustomer.guid);
    customers.remove(existing);
    customers.insert(index, editedCustomer);
    state = customers;
  }

  bool delete(Customer customer) {
    bool deleted = state.remove(customer);
    state = [...state];
    return deleted;
  }
}

final customersProvider =
    NotifierProvider<ViewCustomersNotifier, List<Customer>>(
        ViewCustomersNotifier.new);
