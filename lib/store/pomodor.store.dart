import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodor.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { TRABALHO, DESCANSO }

abstract class _PomodoroStore with Store {
  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  @observable
  bool iniciado = false;

  @observable
  int minutos = 0;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 1;

  @observable
  int tempoDescanso = 1;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    minutos = minutos != 0
        ? minutos
        : estaTrabalhando
            ? tempoTrabalho
            : tempoDescanso;

    cronometro = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoInvervalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void incrementarTempoTrabalho() {
    tempoTrabalho++;
    if (estaTrabalhando) {
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
    if (estaDescansando) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    if (tempoTrabalho == 1) return;
    tempoTrabalho--;
    if (estaTrabalhando) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    if (tempoDescanso == 1) return;
    tempoDescanso--;
    if (estaDescansando) {
      reiniciar();
    }
  }

  bool get estaTrabalhando {
    return tipoIntervalo == TipoIntervalo.TRABALHO;
  }

  bool get estaDescansando {
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  void _trocarTipoInvervalo() {
    if (estaTrabalhando) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
