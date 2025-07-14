import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import 'widgets.dart';

class AllRooms extends StatefulWidget {
  const AllRooms({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AllRooms> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        SizedBox(height: 30),
        _buildTitleAndBtn(context),
        SizedBox(height: 20),
        _buildListOfAcTile(context),
        _buildShowMoreButton(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTitleAndBtn(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15),
        Text(
          AppStrings.allRooms,
          style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => AppRouter.push(context, RouteNames.addAc),
          child: Container(
            width: 100,
            height: 30,
            decoration: AppCards.forCommon1(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppStrings.addAc,
                  style: AppTexts.titleMedium(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                AppIcons.addAcIcon(context),
              ],
            ),
          ),
        ),
        SizedBox(width: 15),
      ],
    );
  }

  Widget _buildListOfAcTile(BuildContext context) {
    return Selector<ACProvider, List<ACModel>>(
      selector: (_, provider) => provider.acs,
      builder: (context, acList, _) {
        return Container(
          height: 310,
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: _showAll
              ? GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 155,
                  ),
                  itemCount: acList.length,
                  itemBuilder: (context, index) {
                    return AcTile(id: acList[index].id, ac: acList[index]);
                  },
                )
              : GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return AcTile(id: acList[index].id, ac: acList[index]);
                  },
                ),
        );
      },
    );
  }

  Widget _buildShowMoreButton() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showAll = !_showAll;
              });
            },
            child: BlinkingText(_showAll ? 'Show Less' : 'Show More'),
          ),
        ),
      ),
    );
  }
}
