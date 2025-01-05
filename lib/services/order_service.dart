import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/order/orders_model.dart';

class OrdersService {
  final CollectionReference ordersCollection =
  FirebaseFirestore.instance.collection('orders');

  Future<void> createOrder(OrdersModel order) async {
    try {
      final docRef = ordersCollection.doc();
      final orderWithId = OrdersModel(
        orderId: docRef.id,
        userId: order.userId,
        productItems: order.productItems,
        totalPrice: order.totalPrice,
        status: order.status,
        createdAt: order.createdAt,
      );

      // Lưu vào Firestore
      await docRef.set(orderWithId.toJson());
      print("Order created with ID: ${docRef.id}");
    } catch (e) {
      print("Error creating order: $e");
      rethrow;
    }
  }

  Future<OrdersModel?> getOrderById(String orderId) async {
    try {
      final snapshot = await ordersCollection.doc(orderId).get();
      if (snapshot.exists) {
        return OrdersModel.fromJson(
            snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrdersModel>> getOrdersByUserId(String userId) async {
    try {
      final snapshot = await ordersCollection.where('userId', isEqualTo: userId).get();
      print("abcd");
      print(userId);
      print(snapshot);

      // Kiểm tra nếu không có dữ liệu trả về
      if (snapshot.docs.isEmpty) {
        return [];
      }

      // Chuyển đổi snapshot thành danh sách OrdersModel và sắp xếp theo ngày tháng
      List<OrdersModel> orders = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          print('No data for doc ${doc.id}');
          return null;
        }
        return OrdersModel.fromJson(doc.id, data);
      }).whereType<OrdersModel>().toList(); // Loại bỏ giá trị null nếu có

      // Sắp xếp theo ngày tháng (từ mới nhất đến cũ nhất)
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return orders;

    } catch (e) {
      print('Error fetching orders: $e');
      rethrow;
    }
  }


  Future<void> updateOrder(String orderId, Map<String, dynamic> updates) async {
    try {
      await ordersCollection.doc(orderId).update(updates);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await ordersCollection.doc(orderId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrdersModel>> getAllOrders() async {
    try {
      final snapshot = await ordersCollection.orderBy('createdAt').get();
      return snapshot.docs.map((doc) => OrdersModel.fromFirebase(doc)).toList();
    } catch (e) {
      print('Error fetching all orders: $e');
      rethrow;
    }
  }
  Future<List<OrdersModel>> getOrders() async {
    try {
      final snapshot =
      await ordersCollection.orderBy('createdAt').get();
      return snapshot.docs.map((doc) {
        return OrdersModel.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching orders: $e');
      rethrow;
    }
  }
}