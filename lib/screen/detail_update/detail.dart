import 'package:flutter/material.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/screen/detail_update/start_rating.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isExpandedDetails = false;
  bool isExpandedReviews = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                products[0].img_link,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '\$ ${products[0].discounted_price}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$ ${products[0].actual_price}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '\$ ${products[0].discount_percentage}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Product Title and Rating
                  Text(
                    '${products[0].product_name}]',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      StarRating(rating: products[0].rating),
                      const SizedBox(width: 4),
                      Text(
                        '${products[0].rating}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In Stock',
                        style: TextStyle(),
                      ),
                      Container(
                        color: Color(0x8CFFFFFF),
                        child: Row(children: [
                          Text('Quantity'),
                          Spacer(),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.remove)),
                              Text('1'),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add))
                            ],
                          )
                        ]),
                      )
                    ],
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8C68EE),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Buy now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Details
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpandedDetails = !isExpandedDetails;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Product Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              isExpandedDetails
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          products[0].about_product,
                          maxLines: isExpandedDetails ? null : 2,
                          overflow:
                              isExpandedDetails ? null : TextOverflow.ellipsis,
                        ),
                        if (!isExpandedDetails)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isExpandedDetails = true;
                              });
                            },
                            child: const Text('More'),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Customer Reviews
                  Customer_review(),

                  // Related Products
                  const Text(
                    'Related Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  // itemCount: 4,
                  // itemBuilder: (context, index){
                  //   return ProductCard(product: products[index]);
                  // },)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  
  Column Customer_review() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Customer Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isExpandedReviews = !isExpandedReviews;
                            });
                          },
                          child: Text(
                            isExpandedReviews ? 'Show Less' : 'See All',
                            style: TextStyle(color: Color(0xFFFA993A)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${products[0].rating}',
                          style: TextStyle(
                            color: Color(0xFFFA993A),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 4),
                        StarRating(rating: products[0].rating),
                        Text(
                          '${products[0].rating_count}',
                          style: TextStyle(
                            color: Color(0xFFFA993A),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    _buildReviewItem(),
                    if (isExpandedReviews) ...[
                      _buildReviewItem(),
                      _buildReviewItem(),
                    ],
                  ],
                );
  }

  Widget _buildReviewItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Mark S.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ...List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Everything I was looking for!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'The Deerma VC25 is a fantastic cordless vacuum for quick, everyday '
            "cleaning. It's lightweight and easy to handle, especially in tight spaces.",
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildRelatedProductItem() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              products[0].img_link,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Deerma VC25 Vacuum Cleaner',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            '\$200',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          
        ],
      ),
    );
  }
}

