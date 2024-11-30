class OrdersModel{
  String order_id;
  String user_id;
  double total_price;
  String status;

  OrdersModel(this.order_id, this.user_id, this.total_price,
      this.status); //status (pending, shipped, delivered, cancelled)


}