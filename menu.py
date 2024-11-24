import psycopg2

# conexion a la DB
def connect_db():
    try:
        conn = psycopg2.connect(
            host="localhost",
            user="postgres",
            password="mapg140605",
            dbname="DBTransferencia"
        )
        return conn
    except psycopg2.Error as e:
        print(f"Error al conectar a la base de datos: {e}")
        return None

# CRUD DE TABLAS

# Función para insertar un nuevo material
def insert_material():
    print("\n=== Insertar Material ===")
    codmt = input("Código del material: ")
    nomb = input("Nombre del material: ")
    unmed = input("Unidad de medida: ")
    cate = input("Categoría: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('insert_material', (codmt, nomb, unmed, cate))
            conn.commit()
            print(f"Material '{nomb}' insertado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al insertar material: {e}")
        finally:
            cur.close()
            conn.close()


# Función para obtener los materiales existentes
def obtener_material():
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_materiales')
            materials = cur.fetchall()
            print("\n=== Materiales ===")
            for material in materials:
                print(material)
        except psycopg2.Error as e:
            print(f"Error al obtener materiales: {e}")
        finally:
            cur.close()
            conn.close()


# Función para actualizar un material
def actualizar_material():
    print("\n=== Actualizar Material ===")
    codmt = input("Código del material a actualizar: ")
    nomb = input("Nuevo nombre del material: ")
    unmed = input("Nueva unidad de medida: ")
    cate = input("Nueva categoría: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('actualizar_material', (codmt, nomb, unmed, cate))
            conn.commit()
            print(f"Material con código '{codmt}' actualizado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al actualizar material: {e}")
        finally:
            cur.close()
            conn.close()


# Función para eliminar un material
def eliminar_material():
    print("\n=== Eliminar Material ===")
    codmt = input("Código del material a eliminar: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('eliminar_material', (codmt,))
            conn.commit()
            print(f"Material con código '{codmt}' eliminado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al eliminar el material: {e}")
        finally:
            cur.close()
            conn.close()
    
# Función para insertar un nuevo asistente
def insert_asistente():
    print("\n=== Insertar Asistente ===")
    codas = input("Código del asistente: ")
    nomb = input("Nombre del asistente: ")
    apel = input("Apellido del asistente: ")
    dni = input("DNI del asistente: ")
    celu = input("Celular del asistente: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('insertar_asistente', (codas, nomb, apel, dni, celu))
            conn.commit()
            print(f"Asistente '{nomb} {apel}' insertado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al insertar asistente: {e}")
        finally:
            cur.close()
            conn.close()


# Función para obtener los asistentes existentes
def obtener_asistente():
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_asistentes')
            asistentes = cur.fetchall()
            print("\n=== Asistentes ===")
            for asis in asistentes:
                print(asis)
        except psycopg2.Error as e:
            print(f"Error al obtener los asistentes: {e}")
        finally:
            cur.close()
            conn.close()


# Función para actualizar un asistente
def actualizar_asistente():
    print("\n=== Actualizar Asistente ===")
    codas = input("Código del asistente a actualizar: ")
    nomb = input("Nuevo nombre del asistente: ")
    apel = input("Nuevo apellido del asistente: ")
    dni = input("Nuevo DNI del asistente: ")
    celu = input("Nuevo celular del asistente: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('actualizar_asistente', (codas, nomb, apel, dni, celu))
            conn.commit()
            print(f"Asistente con código '{codas}' actualizado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al actualizar asistente: {e}")
        finally:
            cur.close()
            conn.close()


# Función para eliminar un asistente
def eliminar_asistente():
    print("\n=== Eliminar Asistente ===")
    codas = input("Código del asistente a eliminar: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('delete_asistente', (codas,))
            conn.commit()
            print(f"Asistente con código '{codas}' eliminado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al eliminar el asistente: {e}")
        finally:
            cur.close()
            conn.close()

# Función para insertar un nuevo encargado
def insert_encargado():
    print("\n=== Insertar Encargado ===")
    coden = input("Código del encargado: ")
    nomb = input("Nombre del encargado: ")
    apel = input("Apellido del encargado: ")
    dni = input("DNI del encargado: ")
    celu = input("Celular del encargado: ")
    nombpo = input("Nombre del puesto del encargado: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('insert_encargado', (coden, nomb, apel, dni, celu, nombpo))
            conn.commit()
            print(f"Encargado '{nomb} {apel}' insertado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al insertar encargado: {e}")
        finally:
            cur.close()
            conn.close()


# Función para obtener los encargados existentes
def obtener_encargado():
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_encargados')
            encargados = cur.fetchall()
            print("\n=== Encargados ===")
            for encargado in encargados:
                print(f"CODEN: {encargado[0]}, NOMB: {encargado[1]}, APEL: {encargado[2]}, "
                      f"DNI: {encargado[3]}, CELU: {encargado[4]}, NOMBPO: {encargado[5]}")
        except psycopg2.Error as e:
            print(f"Error al obtener encargados: {e}")
        finally:
            cur.close()
            conn.close()


# Función para actualizar un encargado
def actualizar_encargado():
    print("\n=== Actualizar Encargado ===")
    coden = input("Código del encargado a actualizar: ")
    nomb = input("Nuevo nombre del encargado: ")
    apel = input("Nuevo apellido del encargado: ")
    dni = input("Nuevo DNI del encargado: ")
    celu = input("Nuevo celular del encargado: ")
    nombpo = input("Nuevo nombre del puesto del encargado: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('actualizar_encargado', (coden, nomb, apel, dni, celu, nombpo))
            conn.commit()
            print(f"Encargado con código '{coden}' actualizado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al actualizar encargado: {e}")
        finally:
            cur.close()
            conn.close()


# Función para eliminar un encargado
def eliminar_encargado():
    print("\n=== Eliminar Encargado ===")
    coden = input("Código del encargado a eliminar: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('eliminar_encargado', (coden,))
            conn.commit()
            print(f"Encargado con código '{coden}' eliminado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al eliminar encargado: {e}")
        finally:
            cur.close()
            conn.close()

# Función para insertar un nuevo laboratorio
def insert_laboratorio():
    print("\n=== Insertar Laboratorio ===")
    codlb = input("Código del laboratorio: ")
    pabel = input("Pabellón del laboratorio: ")
    nraul = input("Número de aula: ")
    codas = input("Código de asignatura: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('insertar_laboratorio', (codlb, pabel, nraul, codas))
            conn.commit()
            print(f"Laboratorio '{pabel}-{nraul}' insertado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al insertar laboratorio: {e}")
        finally:
            cur.close()
            conn.close()


# Función para obtener los laboratorios existentes
def obtener_laboratorio():
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_laboratorios')
            labs = cur.fetchall()
            print("\n=== Laboratorios ===")
            for lab in labs:
                print(f"Código: {lab[0]}, Pabellón: {lab[1]}, Aula: {lab[2]}, Asignatura: {lab[3]}")
        except psycopg2.Error as e:
            print(f"Error al obtener laboratorios: {e}")
        finally:
            cur.close()
            conn.close()


# Función para actualizar un laboratorio
def actualizar_laboratorio():
    print("\n=== Actualizar Laboratorio ===")
    codlb = input("Código del laboratorio a actualizar: ")
    pabel = input("Nuevo pabellón del laboratorio: ")
    nraul = input("Nuevo número de aula: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('actualizar_laboratorio', (codlb, pabel, nraul))
            conn.commit()
            print(f"Laboratorio con código '{codlb}' actualizado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al actualizar laboratorio: {e}")
        finally:
            cur.close()
            conn.close()


# Función para eliminar un laboratorio
def eliminar_laboratorio():
    print("\n=== Eliminar Laboratorio ===")
    codlb = input("Código del laboratorio a eliminar: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('delete_laboratorio', (codlb,))
            conn.commit()
            print(f"Laboratorio con código '{codlb}' eliminado correctamente.")
        except psycopg2.Error as e:
            print(f"Error al eliminar el laboratorio: {e}")
        finally:
            cur.close()
            conn.close()

# Función para insertar una nueva nota
def insert_nota():
    print("\n=== Insertar Nota ===")
    codmv = input("Código de la materia/valor: ")
    codaor = input("Código del autor: ")
    comacr = input("Comentario/acreedor: ")
    codas = input("Código de asignatura: ")
    fcemi = input("Fecha de emisión (YYYY-MM-DD): ")
    coden = input("Código del encargado: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('insert_nota', (codmv, codaor, comacr, codas, fcemi, coden))
            conn.commit()
            print(f"Nota con código '{codmv}' insertada correctamente.")
        except psycopg2.Error as e:
            print(f"Error al insertar la nota: {e}")
        finally:
            cur.close()
            conn.close()


# Función para obtener todas las notas
def obtener_nota():
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_notas')
            notas = cur.fetchall()
            print("\n=== Notas ===")
            for nota in notas:
                print(f"Código: {nota[0]}, Autor: {nota[1]}, Comentario: {nota[2]}, "
                      f"Asignatura: {nota[3]}, Fecha de emisión: {nota[4]}, Encargado: {nota[5]}")
        except psycopg2.Error as e:
            print(f"Error al obtener las notas: {e}")
        finally:
            cur.close()
            conn.close()


# Función para actualizar una nota
def actualizar_nota():
    print("\n=== Actualizar Nota ===")
    codmv = input("Código de la nota a actualizar: ")
    codaor = input("Nuevo código del autor: ")
    comacr = input("Nuevo comentario/acreedor: ")
    codas = input("Nuevo código de asignatura: ")
    fcemi = input("Nueva fecha de emisión (YYYY-MM-DD): ")
    coden = input("Nuevo código del encargado: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('actualizar_nota', (codmv, codaor, comacr, codas, fcemi, coden))
            conn.commit()
            print(f"Nota con código '{codmv}' actualizada correctamente.")
        except psycopg2.Error as e:
            print(f"Error al actualizar la nota: {e}")
        finally:
            cur.close()
            conn.close()

# CONSULTAS/REPORTES

def obtener_notas_con_material():
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_notas_con_material')
            resultados = cur.fetchall()
            for registro in resultados:
                print(f"CODMV: {registro[0]}, CODAOR: {registro[1]}, FCEMI: {registro[2]}, "
                      f"NOMB: {registro[3]}, CANT: {registro[4]}")
        except psycopg2.Error as e:
            print(f"Error al obtener notas con material: {e}")
        finally:
            cur.close()
            conn.close()

def obtener_incluye_por_categoria():
    categoria = input("\nIngrese la categoría para obtener los registros: ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_incluye_por_categoria', (categoria,))
            resultados = cur.fetchall()
            print("\n=== Resultados ===")
            for registro in resultados:
                print(f"CODMV: {registro[0]}, NOMB: {registro[1]}, CATE: {registro[2]}, CANT: {registro[3]}")
        except psycopg2.Error as e:
            print(f"Error al obtener incluye por categoría: {e}")
        finally:
            cur.close()
            conn.close()

def obtener_notas_por_fecha():
    fecha = input("\nIngrese la fecha (formato YYYY-MM-DD): ")

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('obtener_notas_por_fecha', (fecha,))
            resultados = cur.fetchall()
            print("\n=== Resultados de Notas por Fecha ===")
            for registro in resultados:
                print(f"CODMV: {registro[0]}, FCEMI: {registro[1]}, NOMB: {registro[2]}, CANT: {registro[3]}")
        except psycopg2.Error as e:
            print(f"Error al obtener notas por fecha: {e}")
        finally:
            cur.close()
            conn.close()


def mostrar_asistente_pabellon():
    pabellon = input("Ingrese el nombre o código del pabellón: ").strip()

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('mostrarAsistentePabellon', (pabellon,))
            resultados = cur.fetchall()
            if resultados:
                print("\n=== Asistentes del Pabellón ===")
                for registro in resultados:
                    print(f"PABEL: {registro[0]}, NRAUL: {registro[1]}, NOMB: {registro[2]}, APEL: {registro[3]}")
            else:
                print("No se encontraron asistentes para el pabellón ingresado.")
        except psycopg2.Error as e:
            print(f"Error al mostrar asistentes del pabellón: {e}")
        finally:
            cur.close()
            conn.close()


def mostrar_encargado_pabellon():
    pab = input("Ingrese el nombre o código del pabellón: ").strip()

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('mostrarEncargadoPabellon', (pab,))
            resultados = cur.fetchall()
            if resultados:
                print("\n=== Encargados del Pabellón ===")
                for registro in resultados:
                    print(f"PABEL: {registro[0]}, NRAUL: {registro[1]}, NOMB: {registro[2]}, APEL: {registro[3]}")
            else:
                print("No se encontraron encargados para el pabellón ingresado.")
        except psycopg2.Error as e:
            print(f"Error al mostrar encargados: {e}")
        finally:
            cur.close()
            conn.close()

def buscar_materiales_por_nombre():
    patron = input("Ingrese el nombre o patrón de búsqueda para los materiales: ").strip()

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.callproc('buscar_materiales_por_nombre', (patron,))
            resultados = cur.fetchall()
            if resultados:
                print("\n=== Resultados de la búsqueda ===")
                for registro in resultados:
                    print(f"CODMT: {registro[0]}, NOMB: {registro[1]}, UNMED: {registro[2]}, CATE: {registro[3]}")
            else:
                print("No se encontraron materiales con ese nombre.")
        except psycopg2.Error as e:
            print(f"Error al buscar materiales: {e}")
        finally:
            cur.close()
            conn.close()


# MENU/INTERFAZ


def menu_principal():
    while True:
        print("\n=== MENÚ PRINCIPAL ===")
        print("1. Administrar Tablas")
        print("2. Generar Reportes (Consultas)")
        print("3. Salir")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            administrar_tablas()
        elif opcion == "2":
            generar_reportes()
        elif opcion == "3":
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Intente de nuevo.")


def administrar_tablas():
    while True:
        print("\n=== ADMINISTRAR TABLAS ===")
        print("1. Asistente")
        print("2. Encargado")
        print("3. Laboratorio")
        print("4. Material")
        print("5. Nota")
        print("6. Incluye")
        print("7. Volver al menú principal")
        opcion = input("Seleccione una tabla: ")

        if opcion == "1":
            administrar_opciones_tabla("asistente")
        elif opcion == "2":
            administrar_opciones_tabla("encargado")
        elif opcion == "3":
            administrar_opciones_tabla("laboratorio")
        elif opcion == "4":
            administrar_opciones_tabla("material")
        elif opcion == "5":
            administrar_opciones_tabla("nota")
        elif opcion == "6":
            administrar_opciones_tabla("incluye")
        elif opcion == "7":
            break
        else:
            print("Opción no válida. Intente de nuevo.")


def administrar_opciones_tabla(tabla_nombre):
    while True:
        print(f"\n=== ADMINISTRAR TABLA {tabla_nombre.upper()} ===")
        print("1. Seleccionar")
        print("2. Insertar")
        print("3. Modificar")
        print("4. Eliminar")
        print("5. Volver al menú de tablas")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            globals()[f'obtener_{tabla_nombre}']()
        elif opcion == "2":
            globals()[f'insert_{tabla_nombre}']()
        elif opcion == "3":
            globals()[f'actualizar_{tabla_nombre}']()
        elif opcion == "4":
            globals()[f'eliminar_{tabla_nombre}']()
        elif opcion == "5":
            break
        else:
            print("Opción no válida. Intente de nuevo.")


def generar_reportes():
    while True:
        print("\n=== GENERAR REPORTES ===")
        print("1. Obtener notas con material")
        print("2. Obtener materiales transferidos por categoria")
        print("3. Obtener notas según una fecha")
        print("4. Mostrar asistentes por pabellón")
        print("5. Mostrar encargados por pabellón")
        print("6. Buscar materiales por palabra clave")
        print("7. Volver al menú principal")
        opcion = input("Seleccione una consulta: ")

        if opcion == "1":
            obtener_notas_con_material()
        elif opcion == "2":
            obtener_incluye_por_categoria()
        elif opcion == "3":
            obtener_notas_por_fecha()
        elif opcion == "4":
            mostrar_asistente_pabellon()
        elif opcion == "5":
            mostrar_encargado_pabellon()
        elif opcion == "6":
            buscar_materiales_por_nombre()
        elif opcion == "7":
            break
        else:
            print("Opción no válida. Intente de nuevo.")


# Iniciar el programa
if __name__ == "__main__":
    menu_principal()
