

import universidad.*


class Estudiante {
    const property nombre

    const carrerasQueCursa =#{}

    const historialAcademico = []
    
    const property materiasInscriptas = #{}

    const property materiasEnEspera = []

    method inscribirACarrera(_carrera) {
        carrerasQueCursa.add(_carrera)
    }

    method registrarNota(_materia, _nota) {
        self.autorizarNota(_materia)
        const materiaConNota = new MateriaConNota(materia = _materia, nota = _nota)
        historialAcademico.add(materiaConNota)
    }

    method materiasAprobadas() {
        const aprobadas = historialAcademico.filter({ma => ma.nota()>=4})
        return aprobadas.map({ma => ma.materia()})
    }

    method notaDeMateria(_materia) {
        const materia = historialAcademico.findOrDefault({ma => ma.materia() == _materia}, null)
        if(materia == null){
            return 0
        }
        else{
            return materia.nota()
        }
    }

    method cantidadDeMateriasAprobadas() {
        return historialAcademico.filter({ma => ma.nota()>=4}).size()
    }

    method promedio() {
        return historialAcademico.sum({ma => ma.nota()})/historialAcademico.size()
    }

    method estaAprobada(_materia) {
        return self.notaDeMateria(_materia) >= 4
    }

    method autorizarNota(_materia) {
        const materia = (historialAcademico.findOrDefault({ma => ma.materia() == _materia}, null))
               
        if(materia != null && materia.nota() >= 4){
            self.error("materia ya aprobada")
        }
    }

    method listadoDeMaterias() {
        return carrerasQueCursa.map({carrera => carrera.materias()}).flatten()
    }

    method estaCursando(_carrera) {
        return carrerasQueCursa.contains(_carrera)
    }

    method estaInscripto(_materia) {
        return materiasInscriptas.contains(_materia)
    }

    method cumpleRequisitos(_materia) {
        if(_materia.requisitos().isEmpty()){
            return true
        }
        else{
            return _materia.requisitos().all({materia => self.materiasAprobadas().contains(materia)})
        }
    }

    method informacionUtil() {
        const stringDeMateriasAprobadas = self.materiasAprobadas().map({materia => materia.nombre() + ", "})
        const stringDeMateriasEnEspera = self.materiasEnEspera().map({materia => materia.nombre() + ", "})
        return "Materias aprobadas" + stringDeMateriasAprobadas
               "Materias en lista de espera" + stringDeMateriasEnEspera
    }

    method materiasQueFaltaParaRecibirse() {
      return self.listadoDeMaterias().filter({materia => not self.estaAprobada(materia)})
    }
}
























