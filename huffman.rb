def frequencia_diccionario(texto)
  diccionario = Hash.new
  for i in (0..texto.length-1)
      if diccionario.include? texto[i]
          diccionario[texto[i]] += 1
      else
          diccionario[texto[i]] = 1

      end
  end

  return diccionario
end
class Nodo
  attr_reader :value, :left, :right

  def initialize(value, left, right)
    @value, @left, @right = value, left, right
  end
end

class CountObject
  attr_reader :char, :value

  def initialize(char, value)
    @char = char
    @value = value
  end
end

class HuffmanEncoder
  def initialize(texto)
    @texto = texto
    @frecuencias = Hash.new(0)
    @contar_objetos = []
    @nodo_cola = []
    @binary_values = Hash.new
   
  end

  def arbol
    @texto.each_char do |char|
      @frecuencias[char] += 1
    end

    @frecuencias = @frecuencias.sort_by { |_, count| count }
    @frecuencias.each do |char, count|
      @contar_objetos.push (CountObject.new(char, count))
    end

    until @contar_objetos.empty? && @nodo_cola.count == 1
      left = encontrar_min_valor
      right = encontrar_min_valor
      total_value = left.value + right.value
      nodo = Nodo.new(total_value, left, right)
      @nodo_cola.push(nodo)
    end
  end

  def encontrar_min_valor
    return @contar_objetos.shift if @nodo_cola.empty?
    return @nodo_cola.shift if @contar_objetos.empty?
    if @contar_objetos[0].value <= @nodo_cola[0].value
      return @contar_objetos.shift
    else
      return @nodo_cola.shift
    end
  end

  def valores_binarios(node, binary_string = "")
    if node.is_a?(CountObject)
      @binary_values[node.char] = binary_string
      return
    end
    valores_binarios(node.left, binary_string.dup << "0")
    valores_binarios(node.right, binary_string.dup << "1")
  end

  def generar_binario
    encoded_string = ""
    @texto.each_char { |char| encoded_string << @binary_values[char]}
    print("\ncodigo en binario: ")
    return encoded_string
    
  end

  def imprimir_diccionario(hash)
     print("\ncodigo: ",hash.each { |key, value| },"\n")
  end

  def codificar
    arbol
    valores_binarios(@nodo_cola.first)
    imprimir_diccionario(@binary_values)
    print(generar_binario)
  end

end

texto = 'hola'
print("\nfrecuencia: ", frequencia_diccionario(texto),"\n")
nuevo = HuffmanEncoder.new(texto)
nuevo.codificar