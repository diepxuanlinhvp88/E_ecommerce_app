import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/Cart/cart_item.dart';
import '../../model/product.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  Future<void> addToCart(Product product, String userId, int quantity) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);

      // Kiểm tra xem giỏ hàng đã tồn tại chưa
      final cartSnapshot = await cartRef.get();

      if (!cartSnapshot.exists) {
        // Nếu giỏ hàng chưa tồn tại, tạo mới giỏ hàng
        await cartRef.set({
          'cartItems': [
            {
              'productId': product.product_id,
              'productName': product.product_name,
              'price': product.discounted_price,
              'quantity': quantity,
              'imageUrl': product.img_link,
            }
          ],
        });
      } else {
        // Nếu giỏ hàng đã tồn tại, kiểm tra sản phẩm trong cartItems
        final data = cartSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> cartItems = data['cartItems'] ?? [];

        // Tìm sản phẩm trong giỏ hàng
        int index = cartItems
            .indexWhere((item) => item['productId'] == product.product_id);

        if (index >= 0) {
          // Sản phẩm đã tồn tại -> Tăng số lượng
          cartItems[index]['quantity'] += 1;
        } else {
          // Sản phẩm chưa tồn tại -> Thêm vào mảng
          cartItems.add({
            'productId': product.product_id,
            'productName': product.product_name,
            'price': product.discounted_price,
            'quantity': quantity,
            'imageUrl': product.img_link,
          });
        }

        await cartRef.update({'cartItems': cartItems});
      }
    } catch (e) {
      print("Error adding to cart: $e");
      rethrow;
    }
  }

  //read
  Future<List<CartItem>> getCartItems(String userId) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        final data = cartSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> cartItems = data['cartItems'] ?? [];

        return cartItems.map((item) {
          return CartItem(
            productId: item['productId'],
            productName: item['productName'],
            price: (item['price'] as num).toDouble(),
            quantity: item['quantity'],
            imageUrl: item['imageUrl'],
          );
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching cart items: $e");
      return [];
    }
  }

  //update quantity
  Future<void> updateCartItemQuantity(
      String userId, String productId, int newQuantity) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        final data = cartSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> cartItems = data['cartItems'] ?? [];

        for (var item in cartItems) {
          if (item['productId'] == productId) {
            item['quantity'] = newQuantity;
            break;
          }
        }

        await cartRef.update({
          'cartItems': cartItems,
        });
      }
    } catch (e) {
      print("Error updating cart item quantity: $e");
    }
  }



}
