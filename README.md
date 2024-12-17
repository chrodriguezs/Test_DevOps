<p xmlns:cc="http://creativecommons.org/ns#" >This work is licensed under <a href="https://creativecommons.org/licenses/by-nc-nd/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-NC-ND 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nd.svg?ref=chooser-v1" alt=""></a></p>

## Estructura del Proyecto

~~~
/
├── .github/
│   ├── workflows/                 # GitHub Actions Pipelines
├── App/
│   ├── Infra/                     # Modulo de Infraestructura de las Aplicaciones
│   ├── simple-app1/
│   │   ├── Source/                # Codigo Fuente, Dockerfile y requerimientos para la aplicación 1
│   │   ├── main.tf                # Invocación Modulo de Infra para la aplicación 1
│   │   └── plan.tfgraph           # Detalle del Plan para el despliegue de la aplicación 1
│   └── simple-app2/
│       ├── Source/                # Codigo Fuente, Dockerfile y requerimientos para la aplicación 2
│       ├── main.tf                # Invocación Modulo de Infra para la aplicación 2
│       └── plan.tfgraph           # Detalle del Plan para el despliegue de la aplicación 2
├── Infra/
│   └── Env1/                      # Modulo de Infraestructura base del Ambiente 1
├── Docs/
│   ├── media/                     # Diagramas de la solución
│   └── README.md                  # Documentación del los recursos desplegados
├── DESIGN.md                      # Documento de diseño del proyecto
└── README.md                      # Documentación general del proyecto
~~~

## Proceso Despliegue Github Actions 

- Deploy Enviroment (Pipeline de Despliegue del Env1)
- Deploy Aplication (Pipeline de Despliegue de simple-app1 / simple-app2)

## Diagramas de Despliegue Terraform
[Ejemplo Terraform Plan - Simple-app1](/App/simple-app1/plan.tfgraph)

[Ejemplo Terraform Plan - Simple-app2](/App/simple-app2/plan.tfgraph)

![Diagrama de la app](/Docs/media/app-infra.svg)

[Ejemplo Terraform Plan - Infra Env1](/Infra/Env1/plan.tfgraph)
![Diagrama de la solución](/Docs/media/infra.svg)



