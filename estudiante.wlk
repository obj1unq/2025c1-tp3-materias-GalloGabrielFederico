

import universidad.*


class Estudiante {
    const property nombre

    const carrerasQueCursa =#{}

    const property historialAcademico = []
    
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
        return materiasAprobadas.materiasQueAprobo(self).size()
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
        if(not _materia.requisitos().isEmpty()){
            return _materia.requisitos().all({ma => materiasAprobadas.materiasQueAprobo(self).contains(ma)})
        }
    }

    method informacionUtil() {
        return "Las materias aprobadas son" + materiasAprobadas.materiasQueAprobo(self) +
               "Las materias en lista de espera son" + self.materiasEnEspera()
    }

    method materiasQueFaltaParaRecibirse() {
      return self.listadoDeMaterias().filter({materia => not self.estaAprobada(materia)})
    }
}




object materiasAprobadas {

    method materiasQueAprobo(estudiante) {
        const aprobadas = estudiante.historialAcademico().filter({ma => ma.nota()>=4})
        return aprobadas.map({ma => ma.materia()})
    }
}



















