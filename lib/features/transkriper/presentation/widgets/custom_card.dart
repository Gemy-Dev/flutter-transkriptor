import 'package:flutter/material.dart';
import 'package:transkriptor/core/theme/colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, required this.title, required this.description, required this.onTap, required this.icon,
  });
final String title;
final String description;
final VoidCallback onTap;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Container(padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white,boxShadow:  [BoxShadow(
          blurRadius: 20,color: Colors.grey.shade300,offset: const Offset(5, 5),spreadRadius: 1
          )],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CircleAvatar(child: Icon(icon)),
            const SizedBox(height: 20,),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5,),
            Text(
             description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
