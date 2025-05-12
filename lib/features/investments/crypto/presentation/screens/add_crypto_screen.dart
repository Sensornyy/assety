import 'package:assety/features/investments/crypto/presentation/bloc/crypto_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCryptoScreen extends StatefulWidget {
  const AddCryptoScreen({super.key});

  @override
  State<AddCryptoScreen> createState() => _AddCryptoScreenState();
}

class _AddCryptoScreenState extends State<AddCryptoScreen> {
  late final CryptoBloc _cryptoBloc;

  late final TextEditingController _searchCryptoController;

  @override
  void initState() {
    super.initState();

    _cryptoBloc = CryptoBloc()
      ..add(
        CryptoEvent.getTop100Tokens(),
      );

    _searchCryptoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cryptoBloc,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Crypto'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: _searchCryptoController,
              ),
              Expanded(
                child: BlocBuilder<CryptoBloc, CryptoState>(
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: state.maybeWhen(
                        orElse: () => _cryptoBloc.tokens.length,
                        success: (tokens) => tokens.length,
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        state.maybeWhen(
                          orElse: () => null,
                          success: (tokens) => print(tokens[index].logo!),
                        );
                        return Row(
                          children: [
                            CachedNetworkImage(
                              height: 40,
                              width: 40,
                              imageUrl: state.maybeWhen(
                                orElse: () => _cryptoBloc.tokens[index].logo!,
                                success: (tokens) => tokens[index].logo!,
                              ),
                            ),
                            Text(
                              state.maybeWhen(
                                orElse: () => _cryptoBloc.tokens[index].symbol,
                                success: (tokens) => tokens[index].symbol,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
