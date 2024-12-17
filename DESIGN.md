## Descripción

El producto de nuestra empresa está listo para ser desplegado. Aunque nuestro equipo sobresale en desarrollo, tiene un conocimiento limitado de tecnologías de infraestructura y cloud. Em producto cuenta con Dos aplicaciones (FastAPI) que deben ser contenerizadas y desplegadas.

## Requisitos

- [x] Infraestructura con HA y escalable.
- [x] Infraestructura como Código (IaC) con Terraform.
- [x] Documento de diseño (design.md).
- [x] Las aplicaciones deben ser contenerizadas y desplegadas.
- [x] utilizar herramientas como Terraform, Scripting, GitHub, GitHub Actions, AWS S3 y DynamoDB.
- [x] Seguridad, gestión del estado, secretos y soporte multi-entorno.
- [x] Documentación detallada en el README.
- [x] uso de roles IAM. 
- [x] uso de grupos de seguridad.
- [ ] monitoreo/alertas para anomalías a través de AWS CloudWatch o
Datadog.

## Propuestas de Mejora

- [ ] WAF y CloudFront.
- [ ] Contenido estatico en S3.
- [ ] Manejo de DNS con Route 53.
- [ ] Analisis de codigo estatico y pruebas unitarias en pipelines.

## Arquitectura del Proyecto

![Diagrama de Arquitectura](/Docs/media/architecture.png)

## Solución Propuesta

#### VPC (Virtual Private Cloud):

Crear una VPC para alojar los recursos de AWS.
Configurar subredes públicas y privadas para la seguridad y el acceso.

#### Application Load Balancer (ALB):

Configurar un ALB para distribuir el tráfico entre las instancias de las aplicaciones.
Definir reglas de enrutamiento para dirigir el tráfico a las aplicaciones FastAPI.
Configurar en modo Regional para que pueda redundar entre almenos 2 zonas de disponibilidad.

#### Amazon DynamoDB:

Configurar una tabla de DynamoDB para gestionar datos no relacionales que las aplicaciones puedan necesitar.
Configurar en modo Regional para que pueda redundar entre almenos 2 zonas de disponibilidad.

#### ECS Cluster:

Crear un clúster de ECS donde se ejecutarán las aplicaciones en contenedores.
Utilizar AWS Fargate para ejecutar los contenedores sin necesidad de gestionar servidores.
Desplegar en 2 zonas de disponibilidad para lograr una alta disponibilidad de la solución.

- ##### Definiciones de Tareas (Task Definitions):

Crear definiciones de tareas para cada aplicación FastAPI, especificando la imagen del contenedor, los recursos necesarios (CPU y memoria), y las variables de entorno.

- ##### Servicios de ECS:

Configurar servicios de ECS para cada aplicación, que se encargarán de mantener el número deseado de instancias de las aplicaciones en ejecución.

#### Grupos de Seguridad:

Definir grupos de seguridad para controlar el acceso a las aplicaciones y al ALB, permitiendo solo el tráfico necesario.

#### Registros y Monitoreo:

Configurar CloudWatch para monitorear el rendimiento de las aplicaciones y registrar eventos importantes.

#### AWS WAF (Web Application Firewall):

Configurar un WAF para proteger las aplicaciones de ataques comunes como SQL injection y cross-site scripting (XSS).
Asociar el WAF con el ALB para filtrar el tráfico entrante.

#### Amazon CloudFront:

Configurar una distribución de CloudFront para servir el contenido de las aplicaciones y el contenido estático almacenado en S3.
Integrar CloudFront con el ALB para mejorar la entrega de contenido y reducir la latencia.

#### Amazon Route 53:

Configurar un dominio en Route 53 para gestionar el DNS de las aplicaciones.
Crear registros A y CNAME para apuntar al ALB y a la distribución de CloudFront.

#### Amazon S3:

Crear un bucket de S3 para almacenar y servir contenido estático (HTML, CSS, JavaScript, imágenes, etc.).
Configurar políticas de acceso para permitir la lectura pública del contenido estático.