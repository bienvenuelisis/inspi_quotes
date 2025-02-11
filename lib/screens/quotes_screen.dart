import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:smart_quotes/view_models/quote_view_model.dart';
import 'package:smart_quotes/views/base_view.dart';
import 'package:smart_quotes/widgets/w_quote_card.dart';
import 'package:tcard/tcard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({required Key key}) : super(key: key);

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final TCardController _controller = TCardController();

  @override
  Widget build(BuildContext context) => BaseView<QuoteViewModel>(
        key: UniqueKey(),
        vmBuilder: (context) => QuoteViewModel(),
        builder: _buildScreen,
      );

  Widget _buildScreen(BuildContext context, QuoteViewModel quoteViewModel) =>
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Jiffy().yMMMEd.toString(),
                  style: textStyle.apply(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(
                          .5,
                        ),
                    fontSizeDelta: -4,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.daily_fuel,
                  style: textStyle.apply(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontWeightDelta: 5,
                    fontSizeDelta: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          /*SizedBox(
            width: 100.w,
            height: 60.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SizedBox(
                width: 100.w,
                height: 60.h,
                child: WQuoteCard(
                  key: UniqueKey(),
                  quote: quoteViewModel.quotes[index],
                  viewModel: quoteViewModel,
                ),
              ),
              itemCount: quoteViewModel.total
            ),
          ),*/

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
            ),
            child: TCard(
              size: Size(
                100.w,
                58.h,
              ),
              controller: _controller,
              cards: quoteViewModel.quotes
                  .map(
                    (quote) => WQuoteCard(
                      key: UniqueKey(),
                      quote: quote,
                      viewModel: quoteViewModel,
                      onTranslate: () => {},
                    ),
                  )
                  .toList(),
              onForward: (index, info) {},
              onBack: (index, info) {},
              onEnd: () {
                debugPrint('end');

                //fetch all
                quoteViewModel.fetchAll();
              },
            ),
          ),
        ],
      );
}
