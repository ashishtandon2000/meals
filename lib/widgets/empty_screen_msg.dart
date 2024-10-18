part of "widgets.dart";

class EmptyScreenMsg extends StatelessWidget {
  const EmptyScreenMsg(this.message,{super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey.withOpacity(.5),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            child: Text(message, style: Theme.of(context).textTheme.titleMedium,)),
      ),
    );
  }
}
