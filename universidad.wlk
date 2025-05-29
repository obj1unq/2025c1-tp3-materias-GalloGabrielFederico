

import estudiante.*

class Carrera {
    var property nombre

    const materias = #{}

    method agregarMateria(materia) {
      materias.add(materia)
      materia.carrera(self)
    } 
    
    method materias() = materias 

}

object programacion inherits Carrera(nombre = "programacion", materias = #{elementosDeProgramacion, matematica1, objetos1, objetos2, objetos3, trabajoFinal, basesDeDatos}) {
  
}

object medicina inherits Carrera(nombre = "medicica", materias = #{quimica, biologia1, biologia2, anatomiaGeneral}) {
  
}

object derecho inherits Carrera(nombre = "derecho", materias = #{latin, derechoRomano, historiaDelDerechoArgentino, derechoPenal1, derechoPenal2}) {
  
}





class Materia {
    const property nombre 

    const property carrera  

    const property requisitos = #{} 
    
    const property cupo = 3

    const property alumnosInscriptos = #{}

    const property enListaDeEspera = []

    method puedeInscribirse(_estudiante) {
      return _estudiante.estaCursando(self.carrera()) && not _estudiante.estaAprobada(self) && not _estudiante.estaInscripto(self) && _estudiante.cumpleRequisitos(self)
    }

    method inscribirEstudiante(_estudiante) {
      self.validarInscribirse(_estudiante)
      if(self.alumnosInscriptos().size() < self.cupo()){
         alumnosInscriptos.add(_estudiante)
         _estudiante.materiasInscriptas().add(self)
         _estudiante.materiasEnEspera().remove(self)
      }
      else{
         enListaDeEspera.add(_estudiante)
         _estudiante.materiasEnEspera().add(self)
      }
    }

    method darDeBaja(_estudiante) {
      alumnosInscriptos.remove(_estudiante)
      _estudiante.materiasInscriptas().remove(self)
      if(not enListaDeEspera.isEmpty()){
        self.inscribirEstudiante(enListaDeEspera.get(0))
        self.enListaDeEspera().remove(enListaDeEspera.get(0))
      }
    }    

  method validarInscribirse(_estudiante) {
    if(not self.puedeInscribirse(_estudiante)){
        self.error("no cumple requisitos de inscripcion")
      }
  }
}



class MateriaConNota {
    var property materia

    var property nota  
}




object elementosDeProgramacion inherits Materia(nombre = "elementos de programacion", carrera = programacion) {
  
}
object matematica1 inherits Materia(nombre = "matematica 1", carrera = programacion) {
  
}
object objetos1 inherits Materia(nombre = "objetos 1", carrera = programacion) {
  
}
object objetos2 inherits Materia(nombre = "objetos 2", carrera = programacion, requisitos = #{matematica1, objetos1}) {
  
}
object basesDeDatos inherits Materia(nombre = "bases de datos", carrera = programacion) {
  
}
object objetos3 inherits Materia(nombre = "objetos 3", carrera = programacion, requisitos = #{objetos2, basesDeDatos}) {
  
}
object trabajoFinal inherits Materia(nombre = "trabajo final", carrera = programacion) {
  
}

object quimica inherits Materia(nombre = "quimica", carrera = medicina) {
  
}
object biologia1 inherits Materia(nombre = "biologia 1", carrera = medicina) {
  
}

object biologia2 inherits Materia(nombre = "biologia 2", carrera = medicina, requisitos = #{biologia1}) {
  
}

object anatomiaGeneral inherits Materia(nombre = "anatomia general", carrera = medicina) {
  
}

object latin inherits Materia(nombre = "latin", carrera = derecho) {
  
}
object derechoRomano inherits Materia(nombre = "derecho romano", carrera = derecho) {
  
}
object historiaDelDerechoArgentino inherits Materia(nombre = "historia del derecho argentino", carrera = derecho) {
  
}
object derechoPenal1 inherits Materia(nombre = "derecho penal 1", carrera = derecho) {
  
}
object derechoPenal2 inherits Materia(nombre = "derecho penal 2", carrera = derecho) {
  
}
































