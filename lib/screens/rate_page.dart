import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '은행 고시환율',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Color(0xffFEFAF8),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10,20,5,5),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1,
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('미국 USD'),
                          SizedBox(height: 5,),
                          Text(
                            '1,359',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Image.network(
                              'https://ssl.pstatic.net/imgfinance/chart/mobile/marketindex/month3/FX_USDKRW_SHB_search.png?sidcode=1697714653445',),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5,20,10,5),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('일본 JPY 100'),
                            SizedBox(height: 5,),
                            Text(
                              '907',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Image.network('https://ssl.pstatic.net/imgfinance/chart/mobile/marketindex/month3/FX_JPYKRW_SHB_search.png?sidcode=1697714653445'),
                          ],
                        )
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(10,5,5,5),
                      width: MediaQuery.of(context).size.width * 0.5 ,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('유럽 EUR'),
                              SizedBox(height: 5,),
                              Text(
                                '1,436',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.network(
                                  'https://ssl.pstatic.net/imgfinance/chart/mobile/marketindex/month3/FX_EURKRW_SHB_search.png?sidcode=1697714653445'
                              ),
                            ],
                          )
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(5,5,10,5),
                      width: MediaQuery.of(context).size.width * 0.5 ,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('중국 CNY'),
                              SizedBox(height: 5,),
                              Text(
                                '185',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.network('https://ssl.pstatic.net/imgfinance/chart/mobile/marketindex/month3/FX_CNYKRW_SHB_search.png?sidcode=1697714653445'),
                            ],
                          ))
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(10,5,5,5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('영국 GBP'),
                              SizedBox(height: 5,),
                              Text(
                                '1,650',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.network('https://ssl.pstatic.net/imgfinance/chart/mobile/marketindex/month3/FX_GBPKRW_SHB_search.png?sidcode=1697714653445'),
                            ],
                          )
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(5,5,10,5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('호주 AUD'),
                              SizedBox(height: 5,),
                              Text(
                                '858',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.network('https://ssl.pstatic.net/imgfinance/chart/mobile/marketindex/month3/FX_AUDKRW_SHB_search.png?sidcode=1697714653445'),
                            ],
                          )
                      )
                  ),
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}
