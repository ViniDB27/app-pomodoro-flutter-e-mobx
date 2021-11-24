import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/Cronometro.dart';
import 'package:pomodoro/components/EntradaTempo.dart';
import 'package:provider/provider.dart';
import '../store/pomodor.store.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Cronometro(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    titulo: 'Trabalho',
                    valor: store.tempoTrabalho,
                    incrementar: store.iniciado && store.estaTrabalhando ? null : store.incrementarTempoTrabalho,
                    decrementar:  store.iniciado && store.estaTrabalhando ? null : store.decrementarTempoTrabalho,
                  ),
                  EntradaTempo(
                    titulo: 'Descanço',
                    valor: store.tempoDescanso,
                    incrementar: store.iniciado && store.estaDescansando ? null : store.incrementarTempoDescanso,
                    decrementar: store.iniciado && store.estaDescansando ? null : store.decrementarTempoDescanso,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
