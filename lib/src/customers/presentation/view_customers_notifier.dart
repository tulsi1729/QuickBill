import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/customers/models/customer.dart';
import 'package:quick_bill/src/customers/repository/customers_repository.dart';

class ViewCustomersNotifier extends AsyncNotifier<List<Customer>> {
  late final CustomersRepository _repository;
  @override
  Future<List<Customer>> build() async {
    _repository = ref.watch(customersRepositoryProvider);
    return await _repository.getAllCustomers();
  }

  void add(Customer newCustomer) {
    state = AsyncData([...(state.value ?? []), newCustomer]);
    _repository.save(customerJSON: newCustomer.toMap());
  }

  void edit(Customer editedCustomer) {
    List<Customer> customers = [...(state.value ?? [])];
    int index = customers
        .indexWhere((customer) => customer.guid == editedCustomer.guid);
    Customer existing = customers
        .firstWhere((customer) => customer.guid == editedCustomer.guid);
    customers.remove(existing);
    customers.insert(index, editedCustomer);
    state = AsyncData(customers);
    _repository.editByGUID(
        guid: editedCustomer.guid, updatedCustomerMap: editedCustomer.toMap());
  }

  bool delete(Customer customer) {
    bool deleted = (state.value ?? []).remove(customer);
    state = AsyncData([...(state.value ?? [])]);
    _repository.deleteByGUID(guid: customer.guid);
    return deleted;
  }
}

final customersProvider =
    AsyncNotifierProvider<ViewCustomersNotifier, List<Customer>>(
        ViewCustomersNotifier.new);
