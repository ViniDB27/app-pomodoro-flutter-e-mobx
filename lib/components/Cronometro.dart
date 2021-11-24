import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/CronometroBotao.dart';
import 'package:provider/provider.dart';
import '../store/pomodor.store.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(builder: (_) {
      return Container(
        color: store.estaTrabalhando ? Colors.red : Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estaTrabalhando ? 'Hora de Trabalhar' : 'Hora de Descansar',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 120,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                store.iniciado
                    ? CronometroBotao(
                        text: 'Parar',
                        icon: Icons.stop,
                        onPress: store.parar,
                      )
                    : CronometroBotao(
                        text: 'Iniciar',
                        icon: Icons.play_arrow,
                        onPress: store.iniciar,
                      ),
                CronometroBotao(
                  text: 'Reiniciar',
                  icon: Icons.refresh,
                  onPress: store.reiniciar,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
