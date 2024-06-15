import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/entry/model/entry.dart';

class ViewEntryNotifier extends Notifier<List<Entry>> {
  @override
  List<Entry> build() {
    return <Entry>[
      // const Entry(
      //     productName: "bread",
      //     quantity: 10,
      //     productPrice: 50.0,
      //     createdOn: "1 jan 2024",
      //     customerGUID: "1"),
      // const Entry(
      //     productName: "bread",
      //     quantity: 10,
      //     productPrice: 50.0,
      //     createdOn: "1 jan 2024",
      //     customerGUID: "2"),
      // Entry(
      //     productName: "bread",
      //     quantity: 10,
      //     productPrice: 50.0,
      //     createdOn: DateTime.now().toString(),
      //     customerGUID: "3"),
    ];
  }

  void add(List<Entry> newEntries) {
    state = [...state, ...newEntries];
  }
}

final entriesProvider =
    NotifierProvider<ViewEntryNotifier, List<Entry>>(ViewEntryNotifier.new);
