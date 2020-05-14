import ProjectDescription

let targetActions = [
    TargetAction.pre(path: "Scripts/SwiftLintRunScript.sh",
                     arguments: [],
                     name: "SwiftLint"),

    TargetAction.pre(path: "Scripts/RSwiftRunScript.sh",
                     arguments: [],
                     name: "R.Swift",
                     inputPaths: [Path.init("$TEMP_DIR/rswift-lastrun")],
                     inputFileListPaths: [],
                     outputPaths: [Path.init("$SRCROOT/TuistSample/Sources/R.generated.swift")],
                     outputFileListPaths: [])
]

let project = Project.init(
    name: "TuistSample",
    organizationName: "Alexander Holley",
    settings: Settings.init(configurations: [
        .debug(name: "Debug"),
        .debug(name: "Intern"),
        .debug(name: "Extern"),
        .release(name: "Release")
    ]),
    targets: [
        Target.init(name: "TuistSample",
                    platform: .iOS,
                    product: .app,
                    bundleId: "de.alexholley.App",
                    infoPlist: "TuistSample/Info.plist",
                    sources: ["TuistSample/Sources/**"],
                    resources: ["TuistSample/Resources/**"],
                    actions: targetActions,
                    dependencies: [
                        .cocoapods(path: ".")
        ]),
        Target.init(name: "TuistSampleTests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "de.alexholley.AppTests",
                    infoPlist: "TuistSampleTests/Info.plist",
                    sources: ["TuistSampleTests/Tests/**"],
                    dependencies: [
                        .target(name: "TuistSample")
        ]),
        Target.init(name: "TuistSampleUITests",
                    platform: .iOS,
                    product: .uiTests,
                    bundleId: "de.alexholley.AppUITests",
                    infoPlist: "TuistSampleUITests/Info.plist",
                    sources: ["TuistSampleUITests/Tests/**"],
                    dependencies: [
                        .target(name: "TuistSample")
        ])
        // end of targets definition
    ],
    schemes: [
        Scheme.init(name: "Debug",
                    shared: true,
                    buildAction: BuildAction.init(targets: ["TuistSample"]),
                    testAction: TestAction.init(targets: ["TuistSampleTests"]),
                    runAction: RunAction.init(configurationName: "Debug", executable: "App", arguments: nil)
        ),
        Scheme.init(name: "Intern",
                    shared: true,
                    buildAction: BuildAction.init(targets: ["TuistSample"]),
                    testAction: TestAction.init(targets: ["TuistSampleTests"]),
                    runAction: RunAction.init(configurationName: "Intern", executable: "App", arguments: nil)
        ),
        Scheme.init(name: "Extern",
                    shared: true,
                    buildAction: BuildAction.init(targets: ["TuistSample"]),
                    testAction: TestAction.init(targets: ["TuistSampleTests"]),
                    runAction: RunAction.init(configurationName: "Extern", executable: "App", arguments: nil)
        ),
        Scheme.init(name: "Release",
                    shared: true,
                    buildAction: BuildAction.init(targets: ["TuistSample"]),
                    testAction: TestAction.init(targets: ["TuistSampleTests"]),
                    runAction: RunAction.init(configurationName: "Release", executable: "App", arguments: nil)
        )
        // end of schemes definition
    ],
    additionalFiles: [
        "Sources/R.generated.swift"
    ]
)
